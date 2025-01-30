module 0x2fc5594038ff8c91da630fc3d486009b53520f07b126d998fc22332eda9d171f::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"DOG (SUI)", b"THE BIGGEST MEME IN THE WORLD IS ALSO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5597e583513dcd17e34f9c6b4eccc79eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

