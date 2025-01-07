module 0x40f72bd69bfd76ff0537806134e85971a646c5fceeb1d0b46319aaa1da79ef87::sponge {
    struct SPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGE>(arg0, 9, b"SPONGE", b"Sponge on Sui", b"Sponge on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/83ce99023f9c146cb043f9ae501dd18eblob")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPONGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPONGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

