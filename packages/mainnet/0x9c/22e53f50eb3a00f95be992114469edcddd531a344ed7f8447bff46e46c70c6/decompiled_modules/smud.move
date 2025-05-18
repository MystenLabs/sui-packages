module 0x9c22e53f50eb3a00f95be992114469edcddd531a344ed7f8447bff46e46c70c6::smud {
    struct SMUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUD>(arg0, 9, b"SMUD", b"MudkipsOnSui", b"$SMUD the unofficial meme mascot of $SUI. born from swamp memes + 4chan culture, powered by community + early reflexivity vibes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/578b2a3f038f073ee44d6208584e505bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

