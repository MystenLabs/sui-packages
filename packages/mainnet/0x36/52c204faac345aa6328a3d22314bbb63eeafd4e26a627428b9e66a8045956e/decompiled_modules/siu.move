module 0x3652c204faac345aa6328a3d22314bbb63eeafd4e26a627428b9e66a8045956e::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIU>, arg1: 0x2::coin::Coin<SIU>) {
        0x2::coin::burn<SIU>(arg0, arg1);
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"Siu", b"Siu is inspired by Cristiano Ronaldo's iconic Siuu celebration after scoring goals. Siu captures the energy, passion, and celebration of greatness, bringing together fans of football and blockchain enthusiasts alike. Whether you're a Ronaldo fan, a crypto trader, or just someone who loves being part of a winning team, this token represents triumph, excitement, and the spirit of celebration. Built on the Sui blockchain for efficiency and security, Siu offers a chance to own a piece of football history while exploring the future of decentralized finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://magenta-dull-boar-570.mypinata.cloud/ipfs/Qmf6oYn1YWnW4znwD9NajWAT4CRchpL2ot48mSDe7sHJ9h")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIU>>(v1);
        0x2::coin::mint_and_transfer<SIU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

