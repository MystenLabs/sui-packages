module 0xc0a1c395c8892ed49c842f84a1e96773b9745fa276df69ad2d8081665af3db9a::pnd {
    struct PND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PND>(arg0, 9, b"PND", b"PandaPaws", b"PandaPaws is a meme token featuring a humorous and cute design, with a mascot of a panda holding a bao bun. This token not only symbolizes fun but also connects the crypto community through the friendly and adorable image of the panda.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f57ae97-728b-4773-8e5e-92f2a00fb321.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PND>>(v1);
    }

    // decompiled from Move bytecode v6
}

