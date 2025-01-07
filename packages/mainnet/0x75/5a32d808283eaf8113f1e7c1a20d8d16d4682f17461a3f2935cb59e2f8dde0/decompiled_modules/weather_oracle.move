module 0x755a32d808283eaf8113f1e7c1a20d8d16d4682f17461a3f2935cb59e2f8dde0::weather_oracle {
    struct Dice has store, key {
        id: 0x2::object::UID,
        value: u8,
    }

    struct DiceEvent has copy, drop {
        value: u8,
    }

    entry fun roll_dice(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle) : u8 {
        (0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, 1795566) as u8) % 6 + 1
    }

    entry fun roll_dice_nft(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = roll_dice(arg0);
        let v1 = Dice{
            id    : 0x2::object::new(arg1),
            value : v0,
        };
        let v2 = DiceEvent{value: v0};
        0x2::event::emit<DiceEvent>(v2);
        0x2::transfer::transfer<Dice>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

