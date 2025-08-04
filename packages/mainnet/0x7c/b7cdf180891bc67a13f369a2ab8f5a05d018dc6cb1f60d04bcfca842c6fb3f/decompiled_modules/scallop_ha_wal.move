module 0x7cb7cdf180891bc67a13f369a2ab8f5a05d018dc6cb1f60d04bcfca842c6fb3f::scallop_ha_wal {
    struct SCALLOP_HA_WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_HA_WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_HA_WAL>(arg0, 9, b"shaWAL", b"shaWAL", b"Scallop interest-bearing token for Headal WAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://57a73e4limitd7kze2fdwx3d3hrg2y3xs2gpdh4wlhv7exgwfhiq.arweave.net/78H9k4tDETH9WSaKO19j2eJtY3eWjPGfllnr8lzWKdE")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_HA_WAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_HA_WAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

