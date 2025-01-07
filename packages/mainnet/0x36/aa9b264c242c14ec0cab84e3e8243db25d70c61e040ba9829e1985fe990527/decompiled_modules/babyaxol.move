module 0x36aa9b264c242c14ec0cab84e3e8243db25d70c61e040ba9829e1985fe990527::babyaxol {
    struct BABYAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAXOL>(arg0, 6, b"BabyAxol", b"BabyAxolSui", x"426162792041786f6c20697320612066756e20616e642061646f7261626c65206d656d65636f696e20696e7370697265642062792074686520717569726b7920616d7068696269616e207468617473206b6e6f776e20666f7220697473206162696c69747920746f20726567656e657261746520616e64206272696e67206a6f792e204275696c74206f6e2074686520537569204e6574776f726b0a0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241014_171155_62ba4d709f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYAXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

