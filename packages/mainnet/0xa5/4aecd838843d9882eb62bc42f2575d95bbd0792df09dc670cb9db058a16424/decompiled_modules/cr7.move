module 0xa54aecd838843d9882eb62bc42f2575d95bbd0792df09dc670cb9db058a16424::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7>(arg0, 9, b"CR7", b"Cristiano Ronaldo", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUkDzch1AnSrkph7P6wLFeMBi9N2fjUDYJyje4Z39RuwW")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CR7>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

