module 0x53c8ef769fd9c8da4612d42d76031ed49a21aa612c2c03e4809830e9e5cb8b83::suizielovesui {
    struct SUIZIELOVESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZIELOVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZIELOVESUI>(arg0, 6, b"SuiZieloveSui", b"SuiZie", x"5375695a696565656520466f7220416d65726963616e0a49206d616465207468697320746f6b656e20666f7220636f6d6d756e6974792c206a75737420666f722066756e2c206c65747320686974203130306b2420746f676574686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/56_30044a1a6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZIELOVESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZIELOVESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

