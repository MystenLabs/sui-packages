module 0x2c05141dc23420afc1fd43c276aa2c7b6353dda69a7439b53b21035f7c4cd374::catrus {
    struct CATRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATRUS>(arg0, 6, b"CATRUS", b"Walrus Cat", b"This cat identify as a Walrus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catrus_profil_39cef94cd0.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

