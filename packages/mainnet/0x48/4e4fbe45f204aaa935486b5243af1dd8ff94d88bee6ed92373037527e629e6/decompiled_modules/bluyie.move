module 0x484e4fbe45f204aaa935486b5243af1dd8ff94d88bee6ed92373037527e629e6::bluyie {
    struct BLUYIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUYIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUYIE>(arg0, 6, b"BLUYIE", b"Bluyie On Sui", b"Introducing Bluyie on Sui  our very first project, and its a special one! Fun, wholesome, and powered by Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000072457_603760f07b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUYIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUYIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

