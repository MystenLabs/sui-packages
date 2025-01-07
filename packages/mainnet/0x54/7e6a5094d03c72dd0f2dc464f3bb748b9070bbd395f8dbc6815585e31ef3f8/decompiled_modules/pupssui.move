module 0x547e6a5094d03c72dd0f2dc464f3bb748b9070bbd395f8dbc6815585e31ef3f8::pupssui {
    struct PUPSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPSSUI>(arg0, 6, b"Pupssui", b"Pups", b"Puppupspupspups", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4691258769e44d5568956b8265e257b5_f5a81c9112.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

