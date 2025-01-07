module 0x12fa78e3f7567ecc56d710ff1860fccc8a6cbea3be4fdb7cf4cf96f279828a5::bone {
    struct BONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONE>(arg0, 6, b"BONE", b"Bone", b"Bone is a memecoin that makes a difference in sui Blockchain with open source, bone will make the sui community hype", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731071757240.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

