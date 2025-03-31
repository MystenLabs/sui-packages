module 0xd02bd4f5ee37904dccaadc0836952ad2aa68af3ee122ceb49055e4c75c986280::adv {
    struct ADV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADV>(arg0, 9, b"ADV", b"The Adventurer", b"Nene for the adventurer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/19a209b7e6b9e9f93d43d53f6dbeaea4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

