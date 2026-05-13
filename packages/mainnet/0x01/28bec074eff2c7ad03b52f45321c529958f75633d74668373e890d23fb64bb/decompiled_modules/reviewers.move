module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::reviewers {
    struct FormReviewers has key {
        id: 0x2::object::UID,
        form_id: address,
        owner: address,
        members: 0x2::vec_set::VecSet<address>,
    }

    struct ReviewersCreated has copy, drop {
        form_id: address,
        reviewers_id: address,
        owner: address,
    }

    struct ReviewerAdded has copy, drop {
        form_id: address,
        reviewers_id: address,
        by: address,
        member: address,
    }

    struct ReviewerRemoved has copy, drop {
        form_id: address,
        reviewers_id: address,
        by: address,
        member: address,
    }

    public fun owner(arg0: &FormReviewers) : address {
        arg0.owner
    }

    public fun add_reviewer(arg0: &mut FormReviewers, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || 0x2::vec_set::contains<address>(&arg0.members, &v0), 1);
        if (0x2::vec_set::contains<address>(&arg0.members, &arg1)) {
            return
        };
        0x2::vec_set::insert<address>(&mut arg0.members, arg1);
        let v1 = ReviewerAdded{
            form_id      : arg0.form_id,
            reviewers_id : 0x2::object::uid_to_address(&arg0.id),
            by           : v0,
            member       : arg1,
        };
        0x2::event::emit<ReviewerAdded>(v1);
    }

    public(friend) fun assert_for_form(arg0: &FormReviewers, arg1: address) {
        assert!(arg0.form_id == arg1, 2);
    }

    public fun create_and_share(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg1);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::assert_for(arg0, v0);
        let v1 = FormReviewers{
            id      : 0x2::object::new(arg2),
            form_id : v0,
            owner   : 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::owner(arg1),
            members : 0x2::vec_set::empty<address>(),
        };
        let v2 = ReviewersCreated{
            form_id      : v0,
            reviewers_id : 0x2::object::uid_to_address(&v1.id),
            owner        : v1.owner,
        };
        0x2::event::emit<ReviewersCreated>(v2);
        0x2::transfer::share_object<FormReviewers>(v1);
    }

    public fun e_not_allowed() : u64 {
        1
    }

    public fun e_wrong_form() : u64 {
        2
    }

    public fun form_id(arg0: &FormReviewers) : address {
        arg0.form_id
    }

    public fun is_reviewer(arg0: &FormReviewers, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun member_count(arg0: &FormReviewers) : u64 {
        0x2::vec_set::size<address>(&arg0.members)
    }

    public fun members(arg0: &FormReviewers) : &0x2::vec_set::VecSet<address> {
        &arg0.members
    }

    public fun remove_reviewer(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg1: &mut FormReviewers, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::assert_for(arg0, arg1.form_id);
        if (!0x2::vec_set::contains<address>(&arg1.members, &arg2)) {
            return
        };
        0x2::vec_set::remove<address>(&mut arg1.members, &arg2);
        let v0 = ReviewerRemoved{
            form_id      : arg1.form_id,
            reviewers_id : 0x2::object::uid_to_address(&arg1.id),
            by           : 0x2::tx_context::sender(arg3),
            member       : arg2,
        };
        0x2::event::emit<ReviewerRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

