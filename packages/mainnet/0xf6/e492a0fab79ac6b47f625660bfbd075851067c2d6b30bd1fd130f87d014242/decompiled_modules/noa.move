module 0xf6e492a0fab79ac6b47f625660bfbd075851067c2d6b30bd1fd130f87d014242::noa {
    struct NOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOA>(arg0, 6, b"NOA", b"NOAH", b"NOAH is the most beautiful dog meme that has been created so far on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5791731861167394124_y_0eb3492310.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

