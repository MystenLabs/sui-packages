module 0x533ef9442f786c1e20c88ad094661e196ff57130561378e2a6a351c93429d393::user {
    struct User has store, key {
        id: 0x2::object::UID,
        owner: address,
        guid: 0x1::string::String,
        full_name: 0x1::string::String,
        email_address: 0x1::string::String,
        user_role: 0x1::string::String,
        phone_number: 0x1::string::String,
        address: 0x1::string::String,
        created_at: u64,
    }

    public fun get_id(arg0: &User) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_user_address(arg0: &User) : 0x1::string::String {
        arg0.address
    }

    public fun get_user_email_address(arg0: &User) : 0x1::string::String {
        arg0.email_address
    }

    public fun get_user_full_name(arg0: &User) : 0x1::string::String {
        arg0.full_name
    }

    public fun get_user_phone_number(arg0: &User) : 0x1::string::String {
        arg0.phone_number
    }

    public fun get_user_role(arg0: &User) : 0x1::string::String {
        arg0.user_role
    }

    public(friend) fun new_user(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : User {
        User{
            id            : 0x2::object::new(arg7),
            owner         : arg0,
            guid          : arg1,
            full_name     : arg2,
            email_address : arg3,
            user_role     : arg4,
            phone_number  : arg5,
            address       : arg6,
            created_at    : 0x2::tx_context::epoch_timestamp_ms(arg7),
        }
    }

    public fun update_user(arg0: &mut User, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        arg0.full_name = arg1;
        arg0.email_address = arg2;
        arg0.user_role = arg3;
        arg0.phone_number = arg4;
        arg0.address = arg5;
    }

    // decompiled from Move bytecode v6
}

