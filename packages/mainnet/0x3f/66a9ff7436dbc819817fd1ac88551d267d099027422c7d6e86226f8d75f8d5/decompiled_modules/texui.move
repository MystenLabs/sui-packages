module 0x3f66a9ff7436dbc819817fd1ac88551d267d099027422c7d6e86226f8d75f8d5::texui {
    struct TEXUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEXUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEXUI>(arg0, 6, b"TEXUI", b"Weaponized Autism", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAARMAAAC3CAMAAAAGjUrGAAAAk1BMVEX///+/DT4AIFvgmqm8ADEAE1VpdZRPG1LFDDwAHFkPLWYAAFAAHloAGVgAAE4AAEsAF1cAAEkACVO2vMrt7/OsssJMWoDq7PFAT3jh5OoADVTDyNTS1t+gp7rz9fhFVHxbZ4mYn7MQJ145SnYyRHKTmq8sPm6IkKgaNGkAFVt1f5vL0NpdTHTDADBUYYSxt8Z6hJ4Wrv7LAAAEK0lEQVR4nO3ba1PiSBiG4d7sMrOQo6hE5IyCzrjrzP//dQvBIYQn6cSx9oMv9/3RSqfKq2joNI0L/rd6X9wnDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRMNEw0TDRPtXf9mjImQjNaYnBVOlhkmlaLU/QgxqZS9upshJpXCW+dG3SfPRZhczZ277T55LsEkXuwuz7tPnksw2U8d5xad1ygXYBIl+f76WefJcwEm8UNxfY5JWTg7DLjr+slj3yQKx4cBnSePfZP48W1AnkSYHPo1dXaTp+Mnj3mT49RxbpVgUnScOs6NU0yKhqtyyEO3yWPd5GTqOLfptr63bhJvT4Z0nDzWTYab0zHbTpPHukkyPh3zdI9J0N9Wxkw7TR4jJlG/vuSpOmgQN1wYmTOJHp8HtX2bVgdt+vXXbbeRNZN4dPOxm03W5kyCLPzxkXt9T+3Nnf1m2u//I+NtdRfBisluJfI8bR9U1yw8W7XYMQnicNU+SpovZVvFkMlugTaav/cuL2tdxpkyCXrZ5H032ST9mruYMgmi9Kl95LH8LqzbjjRmEgTh47h97KHrsFd7C3Mmu6XKbbcbfL9q2LO2Z7KbP8sOw8eDxg2m/j9/fs58z8X3QetSZZZ6tlK+/vvXp8y7V9BPNl6R+at3C//r3398yvz7J1G48DwVvgT+vSWbJrs3yrDx82eW1ixKLsEkShtfJtdt331ZNektm99NspYvjq2ahNfN7yfL+rWafRPP4+B1y6kLoya912YSN//mnzxGTfx7ka/+I0tWTbyb1i0nzW2aZCMfibu5RJPzZ+Pz9Zv/pLlNk2F16tymz1UV/0lzkybFafJj8y9JFJfH2g6Tx/fJY9KkMnWmg/0TX5QsT1cs3slj0yQv//vVr69v7tcv5V+9h2UtmmR35SQZlQ98p6cMct9zoEWT8r1jEp8+2kThw/EF5PuZhkGT8lzfz/TsrTQ7Phr6Jo9Bk7cfYsh344VX+rYpn3uOLBk0SVZvi5Laz5bh4PAq8hyWtWhS/NPLphdCnBZvN6vmw7L2TIqpM42at6Gj4rv28dUFmeyPxG7829C9eOI7LGvPJM1vFt6le7Bfqvz0TB5zJvFi0mvZbw2Kpcqk8dPYnEnwfN/p91zZuvEyeyZBx5+4NV9m0OTDYYIJJphggsl5mGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaJhomGiYaP8BnBrllt1pQ1sAAAAASUVORK5CYII=")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEXUI>(&mut v2, 55555555000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEXUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEXUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

