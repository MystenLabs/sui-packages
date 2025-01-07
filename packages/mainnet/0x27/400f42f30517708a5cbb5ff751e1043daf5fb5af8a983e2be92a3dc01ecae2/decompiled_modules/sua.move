module 0xe5bad555746563f1429f651a0dc79d47f0cbf68a84349e85ea7882bcd18cda4f::sua {
    struct SUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUA>(arg0, 9, b"SUA", b"SUA TOKEN", b"SUA is a token of Meta version. It has no intrinsic value or expectation of financial return. There is no official team or roadmap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreidexlvadheiqm4esn5bnyruob5olhynfedidkt3o2cl77mypzqhvi.ipfs.dweb.link/")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

