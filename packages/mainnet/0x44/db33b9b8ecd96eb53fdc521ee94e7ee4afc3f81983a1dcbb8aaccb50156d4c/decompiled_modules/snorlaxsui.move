module 0x44db33b9b8ecd96eb53fdc521ee94e7ee4afc3f81983a1dcbb8aaccb50156d4c::snorlaxsui {
    struct SNORLAXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNORLAXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNORLAXSUI>(arg0, 9, b"SNOSUI", b"Snorlaxsui", b"A massive, sleepy critter using a pile of Sui coin pillows, Sui logos drifting above its head like Zzz's.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreid3lvqnndfu3l6tv3p67n6dpmedvyxlqrrysxuowfxu6qkndckc6a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNORLAXSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNORLAXSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNORLAXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

