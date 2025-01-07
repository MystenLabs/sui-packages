module 0x3e331de25c4ff4b32dc9e4713eecfcc25b8701fab047f3f541727d655d76967b::suimaga {
    struct SUIMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAGA>(arg0, 6, b"SUIMAGA", b"Sui Maga", b"Welcome to the first Maga on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_17_26_02_699f53040c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

