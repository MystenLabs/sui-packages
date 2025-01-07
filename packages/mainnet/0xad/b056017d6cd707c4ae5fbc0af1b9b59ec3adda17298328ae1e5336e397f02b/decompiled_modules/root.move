module 0xadb056017d6cd707c4ae5fbc0af1b9b59ec3adda17298328ae1e5336e397f02b::root {
    struct ROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOT>(arg0, 6, b"ROOT", b"Rootlets", b"The Rootlets are friendly creatures that have descended to colonize Earth with their cuteness! Think steampunk space-pigs taking over the Suiverse. $ROOT is the native meme coin for the Rootlets platform. Backed By Suilend and Save Team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731387360687.com")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

