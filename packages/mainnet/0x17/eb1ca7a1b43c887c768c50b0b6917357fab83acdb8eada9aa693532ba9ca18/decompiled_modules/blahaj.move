module 0x17eb1ca7a1b43c887c768c50b0b6917357fab83acdb8eada9aa693532ba9ca18::blahaj {
    struct BLAHAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAHAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAHAJ>(arg0, 6, b"BLAHAJ", b"Blahaj", b"cutest shark ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmYz8udb5V5qcbRdnTpzjCsjHM9YdHVwdFgjSnb6yw1cR9?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLAHAJ>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAHAJ>>(v2, @0x8f2230c27ecda0d0f99bd53965a45774dc8810487cae53063276f770246086c3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAHAJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

