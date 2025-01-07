module 0xaf48d6f32888ab8f7a9064345644a3966c860d36ccdf51a8b2f00890c7e8af88::hohoho {
    struct HOHOHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOHOHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOHOHO>(arg0, 9, b"HOHOHO", b"merry Christmass", b"merry Christmass sub  @MuradGemCalls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/merry-christmas-typography-with-santa-hat-holiday-celebration_1278010-1154.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOHOHO>(&mut v2, 6700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOHOHO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOHOHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

