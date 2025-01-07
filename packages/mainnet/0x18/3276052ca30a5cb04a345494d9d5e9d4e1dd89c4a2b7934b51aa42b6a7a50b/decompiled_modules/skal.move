module 0x183276052ca30a5cb04a345494d9d5e9d4e1dd89c4a2b7934b51aa42b6a7a50b::skal {
    struct SKAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKAL>(arg0, 9, b"Skal", b"Skales", b"Meet Skales a Koi born on Sui. The cleanest fish on the Sui network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3263c9645ed788eaf580a0eb74e30ac4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

