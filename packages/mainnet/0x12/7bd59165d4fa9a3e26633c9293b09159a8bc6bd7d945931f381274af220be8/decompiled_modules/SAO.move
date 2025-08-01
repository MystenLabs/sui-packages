module 0x127bd59165d4fa9a3e26633c9293b09159a8bc6bd7d945931f381274af220be8::SAO {
    struct SAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAO>(arg0, 6, b"SAO JAPANESE", b"SAO", b"the happy girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/89ffde43-909a-48f2-afe3-9023c68d4fd6")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAO>>(v0, @0xb98b463f912e60e2ae74989f69c447fe5d4920c4ee9c399b061384853e0b3e26);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

