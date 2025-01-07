module 0x2318592f41f564834390180640a89cb0d6c9851504cdb6bef3a20d006f2552d1::dory {
    struct DORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORY>(arg0, 6, b"Dory", b"dory", b"Help Find Dory on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/finding_nemo_talking_254f386d01_1c8a8171fb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

