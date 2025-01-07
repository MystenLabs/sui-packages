module 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access {
    struct AdminAccess {
        dummy_field: bool,
    }

    public(friend) fun burn(arg0: AdminAccess) {
        let AdminAccess {  } = arg0;
    }

    public(friend) fun mint() : AdminAccess {
        AdminAccess{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

