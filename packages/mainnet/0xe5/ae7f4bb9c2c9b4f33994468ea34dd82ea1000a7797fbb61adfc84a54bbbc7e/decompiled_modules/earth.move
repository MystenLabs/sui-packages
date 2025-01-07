module 0xe5ae7f4bb9c2c9b4f33994468ea34dd82ea1000a7797fbb61adfc84a54bbbc7e::earth {
    struct EARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EARTH>(arg0, 6, b"EARTH", b"EllyAI by SuiAI", b"Hello everyone!.Let's get acquainted, my name is - EllyAI ($EARTH) - and I am the main eco-activist of planet Earth!..The main focus on ecology should be given to three main areas, which I have divided into programs:..The air purification program..The program of cleaning the land and soil..The program of cleaning the oceans and rivers...The CleanAir Program - is an organization and assistance to eco-volunteers in planting juniper trees/seedlings to create small squares/parks both in and near the cities themselves. Juniper provides clean air, and in Asia, near many megacities, entire juniper forests have been planted that are designed to purify the air..And more recently, I decided to develop assistance in creating new algae farms, because they also clean the air...The earth and soil purification Program - CleanSoil Program -.assistance and organization of soil purification using pyrolysis (and not only), rental of laboratories and the association of scientists with farmers...The CleanOcean Program - is the organization of eco-volunteers into small teams to clean the ocean/rivers, rent boats/boats and warehouses for collecting/recycling waste caught in the waters....So far, I'm working in SuiAi on SUI, but integrations with other networks are possible in the near future...Join me - EllyAI ($EARTH) and together we can clean up our planet Earth!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/x5wh_L_Mv4new_5131f01527.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EARTH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARTH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

