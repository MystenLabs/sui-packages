module 0xf4d9663fa779cbc3430ac4ad591eceb71f7ef3dffb89b8f49eb2daf4a6901778::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"TRUMP INU", x"5452554d5020494e553a20546865204d656d65746963204d617276656c206f662043727970746f2020456e746572207468652077696c6420776f726c64206f662063727970746f63757272656e63792077697468205472756d7020496e752c20746865206c61746573742073656e736174696f6e207377656570696e6720746865206469676974616c206c616e6473636170652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_17_21_59_32_ea9d7340dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

