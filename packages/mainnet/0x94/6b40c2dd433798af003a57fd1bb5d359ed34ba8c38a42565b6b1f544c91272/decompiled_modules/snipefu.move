module 0x946b40c2dd433798af003a57fd1bb5d359ed34ba8c38a42565b6b1f544c91272::snipefu {
    struct SNIPEFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPEFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPEFU>(arg0, 9, b"SNIPEFU", b"Snipefu", b"Eyes like a hawk, reflexes like a ninja. Snipefu snatches the best deals while everyone else is sleeping.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreigwlzqp6dwvs2q4vwqyqg2ww4bpasopj3blaqmiqvhal3e5incqrq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNIPEFU>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPEFU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIPEFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

