module 0xb5c01136929389438ea3b14d7080d0a8869eb452a5e7775a703d8fdfeaa970b::monster {
    struct MONSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTER>(arg0, 6, b"Monster", b"The Monster Library", x"546865204d6f6e73746572204c6962726172790a57656c636f6d65204d6f6e7374657220667269656e64730a466f6c6c6f7720262068656c7020746865206d6f6e7374657273206665656c207361666520616e640a6c6f7665640a4a6f696e206f757220596f75547562652026204d6f6e7374657220467269656e647320636861742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058013_68e8a05128.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

