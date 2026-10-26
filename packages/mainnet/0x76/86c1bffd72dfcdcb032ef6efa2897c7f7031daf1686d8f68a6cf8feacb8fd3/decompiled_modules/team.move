module 0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::team {
    struct Team has store {
        creator: address,
        title: 0x1::string::String,
        url: 0x2::url::Url,
        participants: vector<address>,
    }

    public fun url(arg0: &Team) : &0x2::url::Url {
        &arg0.url
    }

    public(friend) fun add_participant(arg0: &0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::Company, arg1: &mut Team, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg3) || 0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::is_admin(arg0, 0x2::tx_context::sender(arg3)), 0);
        0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::assert_company_member(arg0, 0x2::tx_context::sender(arg3));
        assert!(!0x1::vector::contains<address>(&arg1.participants, &arg2), 4);
        0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::assert_company_member(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg1.participants, arg2);
    }

    public fun creator(arg0: &Team) : address {
        arg0.creator
    }

    public(friend) fun new(arg0: &0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::Company, arg1: 0x1::string::String, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) : Team {
        let v0 = 0x2::tx_context::sender(arg3);
        0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::assert_company_member(arg0, v0);
        validate_participants(arg0, &arg2);
        Team{
            creator      : v0,
            title        : arg1,
            url          : 0x2::url::new_unsafe_from_bytes(b""),
            participants : arg2,
        }
    }

    public fun participants(arg0: &Team) : &vector<address> {
        &arg0.participants
    }

    public fun team_title(arg0: &Team) : &0x1::string::String {
        &arg0.title
    }

    public(friend) fun update(arg0: &0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::Company, arg1: &mut Team, arg2: 0x1::string::String, arg3: vector<address>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg4) || 0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::is_admin(arg0, 0x2::tx_context::sender(arg4)), 0);
        0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::assert_company_member(arg0, 0x2::tx_context::sender(arg4));
        validate_participants(arg0, &arg3);
        arg1.title = arg2;
        arg1.participants = arg3;
    }

    public(friend) fun update_profile(arg0: &0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::Company, arg1: &mut Team, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg4) || 0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::is_admin(arg0, 0x2::tx_context::sender(arg4)), 0);
        0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::assert_company_member(arg0, 0x2::tx_context::sender(arg4));
        arg1.title = arg2;
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg3);
    }

    public(friend) fun update_url(arg0: &0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::Company, arg1: &mut Team, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg3) || 0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::is_admin(arg0, 0x2::tx_context::sender(arg3)), 0);
        0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::assert_company_member(arg0, 0x2::tx_context::sender(arg3));
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    fun validate_participants(arg0: &0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::Company, arg1: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            0x7686c1bffd72dfcdcb032ef6efa2897c7f7031daf1686d8f68a6cf8feacb8fd3::company::assert_company_member(arg0, *0x1::vector::borrow<address>(arg1, v0));
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<address>(arg1)) {
                assert!(*0x1::vector::borrow<address>(arg1, v0) != *0x1::vector::borrow<address>(arg1, v1), 4);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

