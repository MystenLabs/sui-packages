module 0xd343abf4171715d75eacff91c4923491c077cb8b082a96d731ec7a69dede1864::ciko {
    struct CIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIKO>(arg0, 6, b"CIKO", b"CIKO ON SUI", b"Its CIKO, the boss cat of Evan Cheng, the big shot behind the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000119234_7766c26c8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

