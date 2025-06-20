module 0x3bf405a8af7b67353d99ec07c74e05b93964e1ce09c8cb02d4e74fab7774befb::optimus_boom {
    struct OPTIMUS_BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTIMUS_BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTIMUS_BOOM>(arg0, 9, b"OB", b"optimus boom", b"the prime boom. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/e249d4e5-c31a-447a-a950-b1d2e08a787e.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPTIMUS_BOOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTIMUS_BOOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

