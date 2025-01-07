module 0xaa2824f2f87869a3cadbdb06e650350e8885812ea657f9273de01b1f3bd32741::elonpresident {
    struct ELONPRESIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONPRESIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONPRESIDENT>(arg0, 9, b"ELONPRESIDENT", b"Elon President", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fotos.perfil.com/2024/04/11/cropped/250/250/center/elon-musk-1783754.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELONPRESIDENT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONPRESIDENT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONPRESIDENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

