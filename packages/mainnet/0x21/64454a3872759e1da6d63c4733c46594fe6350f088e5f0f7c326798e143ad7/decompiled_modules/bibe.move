module 0x2164454a3872759e1da6d63c4733c46594fe6350f088e5f0f7c326798e143ad7::bibe {
    struct BIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBE>(arg0, 6, b"BIBE", b"Bike Bear", b"Meet #BIBE, the most chill bear in the cryptoverse. Join the ride and let's make some serious gains together. HODL your $BIBE and lets watch this token soar!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logomov_26fa18dd4a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

