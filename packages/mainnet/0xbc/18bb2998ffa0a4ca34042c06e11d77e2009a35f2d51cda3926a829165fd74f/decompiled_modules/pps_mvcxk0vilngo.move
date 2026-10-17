module 0xbc18bb2998ffa0a4ca34042c06e11d77e2009a35f2d51cda3926a829165fd74f::pps_mvcxk0vilngo {
    struct PPS_MVCXK0VILNGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPS_MVCXK0VILNGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPS_MVCXK0VILNGO>(arg0, 9, b"PPS", b"Pumpsui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/PTj-dZif03tlaLp1mm4KfxwC4pIyyz--4nvdo4VIjIc")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPS_MVCXK0VILNGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPS_MVCXK0VILNGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

