module 0x51f00a73d33a33cd6302b16d16d277820cd77655db75f6a4fe9d8192f2bd6b83::suiball {
    struct SUIBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<SUIBALL>(arg0, 6, b"SUIBALL", b"Suiball Robot", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRkgEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/EREahATEdNNFC5SI/k+Ald8DVlA4IAwEAADwFQCdASqAAIAAPm02l0ikIyIwJRgI4gANiWcA1pxsTc5iYVG4Du2tfjVw8tDSBTKPHX9R+wZ/K/7h1qvRVGsWg6te3lHw5xVX15+SWIgIoVcSYPwb4x0DQPxv886JH6Cd5MY5i37lDtWjb4uGYQ05dPIcdgTZ8opFLiZeD1clP2yN4MeULGhIEshZGT4gHWr+z2p5MfvpkwcKtDcJmO0THGKBKRuit4O0TrQwgi97yIlt2jxouALYAP78rRAATrGdCWNkE5tr4KutwizrKQ/zZ2dzqp17+V2yoEfsVzBnblK4SPY1INhW3GaExmS/JNu4bCY28Ng0KOiESZVtV3+QTd+Vn2+IH5X5488ebArcoz5fOV+hF86gP/3ERxW/UtXgj3+aZ2sxPQ+kb8Dg21fJJAf6dcqWUqXyY0o0lgPxUcpa303nfhYkklNwBgMQk3KNklgo0gYodVkTO/7vNAkJzZWp4O4hsatd6ITa0sJzer4h9x/NGNOjsaPkbzibauudiO/4D8j4p0kDYFs9iOvg+c/PtHorF7B30zEVuseS3dT9XZCce2O/jH39HbdJOQlEZe+Zc00lfPf4uJScIZVzgryJ4fUVn4FPfiQMyIe9p1DzJPjqOLam72NSL6O28fm5NmjrlxDnyKiMlfwPGt9UalqaRIm4A83uPG1OLS1LF7FrZd9mgaQRRyvycNHuMOHKT18wyb23JgGQq33S72XwNdyoevj/4I+O1EqWoL98ka9/yxNJ/AbdC4YJsFLvf+Jp/sPwXYqQuYz+uR4PW8oiB2O32MWjSrPOLg7ZH7BX5L9STH56oV1CX9TiHQjehcWEZ2fqmyapmVVGYlhII9OuRyIEvWzYXwU0lU/8HY9govaPelz/pZ06thI0NaIP/FWgGEybvFy42Z03Io3JBLcV3r/1pOL4JoXkRraWADDO/ngqowiS7VmSNNEgh5E1I9OZP/6y5/9UKIy4bZYm2o9NquElfe/4aQdfc76BmNJm/rOdZDud5/6/u3TUbLOhkA8JU75cYJ1+6oXnctw3fbyo7DC5gepCIdXoHan9P71F0DbMZPASsDTf1Pbfnbz6UKip7FZS8cXuo1gKYDKrwtA1U/OWTYS/VHCY5JZ0F9tgRX+UlW6lwrrlff7zqGP+lcX8NM2Xh+BVUZV/voTlJ9DBDfGvn0oet6TvPmH8xNXCpqqEydEClTIrze/DzsMWyXJVuQRDU2dOAM2Eum8G7vvoHUNgGhjV4JOpr+86/lvaEqhVEmbBrd2wkM95a0DkDPDQjvtBvojABuheouH71AR0LG1MjOgj4uGMIn7aMok/fjYOpoFCwkTXTuR03SSN3yC5r9vqIK35TokGXMKK//+4I3Il4k7MuKVFgAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

