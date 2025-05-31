module 0xa99e929d8df80c02429d81ba65876f3f9dbe736e953e2694ac7568a37638d834::kardus_sui {
    struct KARDUS_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARDUS_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARDUS_SUI>(arg0, 9, b"kardusSUI", b"Kardus Staked SUI", b"Kardus LST of SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRj4FAABXRUJQVlA4IDIFAACQIgCdASqAAIAAPm0ukEWkJ6GYuv3seAbEsYBmwSPwH0+p94SyH69frB21/mR88Pzr76dYGm9279zSlbzhZetHJC1XPUA7zvQ/0K5hrtN3q/8jdfMLg2JT2BLg5hmk/1oHbD1/zzFr1kJJwfafH/rGI2/cPFAXmT05uofyihh7wc+cig8qDnTIOmaPMtGU7uPnLhrL99ew+/bGVo59f4g3KvtECwNLVzNit+y5Ca0AdyWuWWla54lV71DPwSPaNFF4QEN2++A5k+J0lF5B7p01RZ4ApYAmd7/JN4aTnw/F4jZd36yx9t3kAF+E0HGq0hE5NYjUixVv37GuH6yITwGmlIBLpfOAl9fUJ0KLHkEo7yUITda0eMYuwAzrLAAA/v12cAGDrAGoL8Xe69+snOQB+P2H4qFSeR5J9Nn2cHoYtnfGN8cX2U6ieoMoynnd+qT6cxzSI/LV3fTXAaNgKA29d5WXGeGeq2BBV3JjG0Pf1CEmFt3n1Ut71Jw4JfIWOvmeQpYgCsIuFZzLFHTCb6ABAbMi4B9niacxO3JIWAzJMLIkLAAzXoxEuAWAVg0UOft8zEuXmW/VpcGuh3zCbv/8NrMQbYG55RAcH7tkeXpOKr5NmRgI/LoDKXne3Ks288kacQ/l0FzI3ffAvDvrLa/COsI70MyRKq0vyOUzvDM5joV6nh7pydurH/E/54P1hiOAk5/vizNkiNE9q5zX8AIvQq5dFNxfFu+eSBvdCXStTziYqtIFn11cgIxPq7sLpSaXxrINg5YzgarEkGJOoy5y7D8WtJnBrNUjG9z9ZX9ocTL4TCdTqm9iOo04ZbJzEq9/hDXfI4i15kfkQlhele6uce0a6HSqhGv7987LV3R7eZpRG/kgvoWX0qFSTd9hw8Guj2hKIp+emPhE2Y51jYBf2tBAA/6shMfAcVhZ82u57eIAXe28dao+sxLG8q7fpEkjjU0A+3A6z3TaDeEK2aWCz4EKEkf9fehkys10Yj6Zlit1vaYbRt7DMqJc+gHoM9TBGbC8Z6C1G/Wno/jiSG8j2ZpZ83LWQAa9Z4WUwrQtzhCDuKfNzdAa/MrF/kwg6YwOXE95jHslVsyVPMMdq68qZ9SMptVbYaWbOF4Ym6xQMob28lsAkQK1AtFxTTtoq8Ide4ZyhKWh+Y2bsvriX1Cdy2ATy/VTuyqBybj4jhc7cSjkOHaOH0EIsUfQ3w4eFDc4aMPWE1cRXAeF3VHcWkp/TPfmxlKFijBUQARfovwdZ6MEgXaDhwtSOI1SCvOZi/cHVWgntkfTSktVhEtZQ3s/NJ5fyEIL/jDhSTeYrgFFTBMVMen7m9ZrEJyjl7YkVKx0ZuFdhiTCTuRY7rfBKZKlprNN3fOq9w1KseKww1HU3zisPwS095UG1vWtOi4dRnPbgRBCzfL4YyfxNpbbKcsQSJZJ3JafzKiBpaKLljMCb3eoCOFtxpmVWmwgBrOzUvYAmtCN60c1WAjNJaWBS5XYuM169OTqqt0bUmh8MQ0N62BYBdR8niFX7MTIMhPFPvtL2YlYM09GP84q8JZEiZJMRvQHZ4/YHiiERmoA5iKd+VwnUY9m7gBeDFi/rP2AFGC6qNJM5hRmSd7OiVmhhiQOOaFPLRy6xYe/rQ97qGA8OPyoUXKfNbuEA6KOvduMw9VwcSsPFg5fLmwQk78m3NqwBl/oABIaIAAD6cWd8sfR7UeIzaY3inIpIvVkQ6Qcotig6M9Z6xHtojP4oDiuic3b4V0csuknRAyMVYVpKWXawAAA")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARDUS_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KARDUS_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

