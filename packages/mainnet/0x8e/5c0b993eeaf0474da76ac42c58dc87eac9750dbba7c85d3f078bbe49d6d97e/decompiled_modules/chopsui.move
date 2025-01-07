module 0x8e5c0b993eeaf0474da76ac42c58dc87eac9750dbba7c85d3f078bbe49d6d97e::chopsui {
    struct CHOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHOPSUI>(arg0, 6, b"CHOPSUI", b"Chop Sui & HODL, WAGMI, TRUST the process. ", b"Chop Sui is a 99 year old feline agent from 1925, who shows us how to HODL our bags, how to protect the helpless, and beyond that, how to connect our past to our future. ..HODL, WAGMI, TRUST the process. ..In 1848 a gold rush started in Northern California. USA. 176 years later, another gold rush has started, a digital gold rush, a 'Sui gold rush', in the same exact region, Northern California. ..Reality is cyclical...In 1925, 99 years ago, the old Disney, which was also established in California, released its '22nd' (ever) cartoon 'Alice Chops the Suey'. In this cartoon, our agent, 'ChopSui', was born. ..This simple cartoon along with a second one produced by a different studio in 1930 called 'Chop Suey', both echo a similar warning about invading foreigners who may cause harm to our bags, our women, and our lands. ..At that time, Chinese communities in the area were notorious for introducing opium, being the primary culprits in its spread. Thus the theme of Chop Suey cartoons. Today, the Chinese significantly influence Silicon Valley's digital landscape through substantial tech investments, echoing past concerns with new risks...........Similarly, California state today, is now being invaded by migrants.......If we take a look at Disney, once it was novel and organic, but today Elon Musk tells Disney 'GO FUCK YOURSELF'. So we can see... the past and future are very much interwoven......Indeed, all of these histories and futures are interwoven, with great opportunities ahead in the Sui digital gold rush, yet in the physical space we face risks and dangers... ChopSui is here to help us unravel it all and to push forward the Sui chain !!! ..ChopSui is here to discuss these most interesting topics. But most importantly ChopSui will encourage us to HODL. For HODLing, is the real way to make it, and WAGMI. ChopSui teaches us to protect the innocent, beware invaders with mal intent 'negarious' drones, and reminds us HODL, WAGMI, TRUST the process. ..1925 'Alice Chops the Suey' Walt Disney.https://www.youtube.com/watch?v=wtviUlCtDLI..1930 'Chop Suey' Terrytoons.https://www.youtube.com/watch?v=0Eczf92kKB4..HODL, WAGMI, TRUST the process. ..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2024_12_19_at_12_25_40_AM_f224bf26f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHOPSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

