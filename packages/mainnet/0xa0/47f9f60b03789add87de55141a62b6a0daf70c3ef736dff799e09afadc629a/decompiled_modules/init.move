module 0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::new<INIT>(&arg0, arg1);
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::borrow_mut_id(&mut v0), arg1);
        0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::vault::create_vault_and_share<INIT>(&arg0, 0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::borrow_mut_id(&mut v0));
        0x2::transfer::public_share_object<0xa047f9f60b03789add87de55141a62b6a0daf70c3ef736dff799e09afadc629a::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

