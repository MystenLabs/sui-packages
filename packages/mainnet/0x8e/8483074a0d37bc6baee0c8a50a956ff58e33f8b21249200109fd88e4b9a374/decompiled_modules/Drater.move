module 0x8e8483074a0d37bc6baee0c8a50a956ff58e33f8b21249200109fd88e4b9a374::Drater {
    struct DRATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRATER>(arg0, 9, b"DRATER", b"Drater", b"Drater is here ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/d723839a-211b-443e-ba66-dd7980930366.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRATER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRATER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

