module 0x3c23a1209597c9f8becf1d209f028c985ea05628d3c810cc229ed8e1ad036198::Italy {
    struct ITALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITALY>(arg0, 9, b"ITALY", b"Italy", b"italy is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz3VZJRakAAzr_A?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ITALY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITALY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

