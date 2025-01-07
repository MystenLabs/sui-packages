module 0x4cca4c3b0fd138ee45a07226496bb299e5554255a89c415e2a635c7c2b591ffb::chippy {
    struct CHIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPPY>(arg0, 6, b"CHIPPY", b"FISH N CHIPS", b"CHIPPY ON SUI IS THE FRIENDLY FISH AND CHIPS YOU ALWAYS NEEDED. IT IS THE BEST COMBO IN ALL THE SUI. JOIN OUR COMMUNITY TO FIND OTHER FISHY FRIENDS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n169sk_Yp_400x400_5d384e1f6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

