module 0x70cd22e8039c367d4c379401506161fc76aa10dd77014b9dc87b9742e79a049f::suimge {
    struct SUIMGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMGE>(arg0, 6, b"SUIMGE", b"MygirlfriendSu", b"A girl named Suimge,around 18 years old, with prosthetic nails, cool and stylish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015353_72b5703f2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

