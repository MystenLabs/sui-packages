module 0x8764a1c092080586ead9e281ded96c85d8963f34f7784e583dd754c0035079ff::socketsui {
    struct SOCKETSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKETSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKETSUI>(arg0, 9, b"SCKSUI", b"Socketsui", b"An electrical outlet with googly eyes, sparking with Sui-shaped lightning bolts and a cheeky grin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreianxtnzrgfmoxaevskzmf7hcbaj2lh2uoyzpxwezboirih6n6zere")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOCKETSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKETSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCKETSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

