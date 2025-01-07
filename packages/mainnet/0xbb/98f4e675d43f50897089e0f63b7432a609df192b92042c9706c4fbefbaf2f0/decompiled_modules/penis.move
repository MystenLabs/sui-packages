module 0xbb98f4e675d43f50897089e0f63b7432a609df192b92042c9706c4fbefbaf2f0::penis {
    struct PENIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENIS>(arg0, 6, b"PENIS", b"Perplexing Enigma of Networked Intelligence in SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"0xf33fd1836f56c87b8f45cfc457e09f4b2cd4b5dd35fb60d06bdaf0313e77f6aa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENIS>(&mut v2, 6969696970000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

