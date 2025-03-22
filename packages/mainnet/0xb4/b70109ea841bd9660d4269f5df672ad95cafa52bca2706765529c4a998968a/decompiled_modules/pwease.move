module 0xb4b70109ea841bd9660d4269f5df672ad95cafa52bca2706765529c4a998968a::pwease {
    struct PWEASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWEASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWEASE>(arg0, 9, b"pwease", b"PWEASE", x"594f552053484f554c44412053414944205057454153450d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmboNoCSu87DLgnqqf3LVWCUF2zZtzpSE5LtAa3tx8hUUG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PWEASE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWEASE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWEASE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

