module 0x3bc367780dd14fdff17f11b59c333a4200f22146d0c204e0742b50d800bc98b::dawng {
    struct DAWNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWNG>(arg0, 6, b"DAWNG", b"Dawng The Dog", x"44414e574720434f494e0a5468652041492063727970746f2070726f6a65637420666561747572696e672043757474696e67206564676520414920746f6f6c732c2064656c69766572696e672041492d67656e65726174656420696d6167652c2074726164652c20776973646f6d20616e642073706f727420626574207069636b732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049442_2baa2b2879.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

