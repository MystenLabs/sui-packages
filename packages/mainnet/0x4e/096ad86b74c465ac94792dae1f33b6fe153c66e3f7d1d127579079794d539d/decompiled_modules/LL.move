module 0x4e096ad86b74c465ac94792dae1f33b6fe153c66e3f7d1d127579079794d539d::LL {
    struct LL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LL>(arg0, 6, b"LL", b"Lirili Larila", x"4c6972696cc3ad204c6172696cc3a02c20656c6566616e7465206e656c206465736572746f206368652063616d6d696e61207175612065206cc3a0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmPPGs38LT3JRLrK1ERZxDXSa24jcZFjNCpXYHSEDt7R2a")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

