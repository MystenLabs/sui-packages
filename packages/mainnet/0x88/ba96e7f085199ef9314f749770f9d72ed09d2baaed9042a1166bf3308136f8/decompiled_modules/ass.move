module 0x88ba96e7f085199ef9314f749770f9d72ed09d2baaed9042a1166bf3308136f8::ass {
    struct ASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASS>(arg0, 9, b"ASS", b"ASS", b"Blast needs better Devs. It's an embarrassment!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASS>>(v2, @0x341e34c6e78efa411d91c73809eb5bee7669f5c9da0421de6dc21857f8b68f57);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

