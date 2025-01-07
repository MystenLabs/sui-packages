module 0xbeae43f43f2711db73da3b353ffe02adbe0c180ae4108dfc49b280cc3b9d058b::echox {
    struct ECHOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHOX>(arg0, 9, b"ECHOX", b"EchoX Runner", b"EchoXRunner is an innovative 3D platform game that combines the exhilarating experience of voice-controlled gameplay with the cutting-edge world of Web3 technology. Players take on the role of unique characters, each with distinct abilities and backstories, as they navigate through immersive environments filled with challenges and obstacles. Utilizing voice commands or manual controls, players must guide their characters through perilous levels, jumping over chasms, dodging hazards, and overcoming puzzles to progress. The game features multiple thrilling modes, including a solo campaign, competitive 2v2 battles, and an intense capture-the-flag mode.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ed6fa22679b733f2df120ed60a630609blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECHOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

