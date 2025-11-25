module 0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::config::new<INIT>(&arg0, arg1);
        0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::config::borrow_mut_id(&mut v0), arg1);
        0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::vault::create_vault_and_share<INIT>(&arg0, 0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::config::borrow_mut_id(&mut v0));
        0x2::transfer::public_share_object<0x8e99fadf9a35f13664254c9b252f8c398cd8f5e28536c9fdd4609c678e496282::config::Config>(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

