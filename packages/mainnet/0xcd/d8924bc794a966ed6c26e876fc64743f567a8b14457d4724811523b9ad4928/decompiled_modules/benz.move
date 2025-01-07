module 0xcdd8924bc794a966ed6c26e876fc64743f567a8b14457d4724811523b9ad4928::benz {
    struct BENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENZ>(arg0, 6, b"BENZ", b"$BENZ - Moo Deng's Dad", x"4b656570657220626568696e6420766972616c20686970706f204d6f6f2044656e672073686172657320686973206a6f75726e657920616e642070726f6d6973657320746f206d616b65206865722066616d6f75730a4d6f6f2044656e6773207269736520746f2073746172646f6d206973206c617267656c7920637265646974656420746f20686572206b65657065722c204d722e2041747461706f6c204e756e6465652c20616c736f206b6e6f776e206173205042656e7a2c2077686f20686173206265656e2064696c6967656e746c7920636172696e6720666f72204d6f6f2044656e6720616e642068657220616e696d616c20636f6d70616e696f6e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_19_11_57_0c6ddf7080.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

