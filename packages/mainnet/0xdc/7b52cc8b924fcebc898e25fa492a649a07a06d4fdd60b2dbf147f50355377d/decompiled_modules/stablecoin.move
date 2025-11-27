module 0xdc7b52cc8b924fcebc898e25fa492a649a07a06d4fdd60b2dbf147f50355377d::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xf0ff90bc955da6698827e49c8f6deeb054bd3ba6117f8574211c4b6a3aa97016::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xf0ff90bc955da6698827e49c8f6deeb054bd3ba6117f8574211c4b6a3aa97016::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

