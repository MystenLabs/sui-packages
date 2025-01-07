module 0x759aa690bacaec9c8d77b57540d759ddc3274bfab2a2c4b08161175ee29567e4::dwif {
    struct DWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWIF>(arg0, 6, b"DWIF", b"DroneWifHat", b"A New Jersey Drone just looking for friends, but wearing a hat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_1_99be7fe1a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

