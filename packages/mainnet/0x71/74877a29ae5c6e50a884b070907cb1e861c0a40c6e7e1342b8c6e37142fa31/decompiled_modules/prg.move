module 0x7174877a29ae5c6e50a884b070907cb1e861c0a40c6e7e1342b8c6e37142fa31::prg {
    struct PRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRG>(arg0, 9, b"PRG", b"Paradigym", b"Paradigym Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9e761b7e49cd7ba8943a933256454136blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

