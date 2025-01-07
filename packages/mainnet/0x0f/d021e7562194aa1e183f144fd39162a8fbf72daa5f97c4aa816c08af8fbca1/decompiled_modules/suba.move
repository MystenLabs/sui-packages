module 0xfd021e7562194aa1e183f144fd39162a8fbf72daa5f97c4aa816c08af8fbca1::suba {
    struct SUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBA>(arg0, 6, b"SUBA", b"SUBAINU", b"suba inu, or suba, is the main token of our ecosystem, bringing the power of a decentralized, community-led currency to millions across the globe. since its inception in 2024, the sui based suba token has grown to become a worldwide phenomenon, and is now accepted as a form of payment at hundreds of locations, either directly or through third-party intermediaries. with added governance, suba will be solidified as an elite top-20 token of the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qme1784MTRCLjKvcgYjgHGnVHUJuEh4kgFvTpPuaQQHibq?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUBA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBA>>(v2, @0x6971cbccabd72aadc5f45830c4c6b61f44569cef40952da301229db53891e166);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

