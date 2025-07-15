module 0xa174a684eace55ceb0aa26f5f54684a80dc804ada8aaac659dadfbfbd297691b::happy {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<HAPPY>(arg0, 6, b"HAPPY", b"ok then", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRlgFAABXRUJQVlA4IEwFAAAQHACdASqAAIAAPm02lkikIyIhIxVaMIANiUAZr5kCbZYVo/0fJhRj6EPVN+bfRA6eHmF/a/9o/fV6QD+vf5XrQ/QA8uD9qvhW/dD9sfa0eUwfXwT0uk0Hyeorltcm///6QE+U64YzXRAxsoFdlnOy2AYoj9nKC4FdZPgdCUWbEibfTuXyJXxjM67EHEfC+VfjhjMx5BJ+pdFON+NHO158qJBfXne27+kdWZM+BeeEIv1Fg0MsgSrxHXjHwmJnduInaD8UgWJyH6jUQVKjvwB37iXbkrQBXXwB5D9pU7JrerunNds3i0BpAAD+8QTM9X/9/qv/v6r/7+q+8T/+cS/9E/2Bngh2s2U/h0W7TaR8v3gOt//GJPkLvkZrzYcCt58+PBm9oQGTmbTaO47BhR8SQA7zWutpxu2qtaU69jPK0/8MZi8VXytzXBgnewhvG2xWL7KLL7l7QIiR0tTU8DT9xUZSTNakrE08sXi6kd0n5UZc9Jh7U4/OpxTgrC3h0n4xHeqp1pHv7psHSpHAjgBTOlVv+YFLz2AFi32X7rDpXH0I9ApIHSgxP5Nedubs7M6vLaffvkuQcsDIjxtDhg7fKHqS19/4wzFyIs016m++jK6XJxouesv77Me9cCSxONUIfiQ3wue9Ti5dfD5YQoYaP8PoB7vfi8qv5a+bHkF6mZbWZMA93QDH+nV89xSo0eKYq0KREHF5Oyudi9Rm6lHISX/Fkn0W4X0oA/jMliPjpBx3FvQIHtuxCt/j8x8Njzkq4AbtZ62YtZvmPagIigX2iC6a1Od8dZwPaxnSzrT15BvjsGFNgiB7grWBxSN79R3A5N82gywp5jD1UsljQINpHuekUeJJMzXn0sjTtN6wQMz7yoRjYFqEL+ufy/rLdUCqzQqpEtyEJaOKw9x6+fIApQRNaeISlGsRX4YEPPHPn98sun7S5Bh1mz0faylT9kzqSS11tlp/53Pc/0jErTKVLunXp2lIF7ivzTFkqozUuVzcYwdoxMuCpb6aGVlACq0rgZgcJjdDHSc7Kcq+zBeBSTier4k5Z4+km6AG9KJLbvLkKvVnordNtddWQM/5uJXK0cHOPAjYjlyKWrv+zwXWuaIfJmJBMQ7MTSkLxKTXdFC3EOGyF+gnG5z+NnFGDKbLjukBYvbz4Sjg30n5v1C4E1AKsPuefzqVkPfugQOiANXnrwoXxy+V8exvr02Fjm/o2lQ5xHmxf+fDzk9DzpmTpznEWD/yO0FcUZ4DODgmr3/PraBG5yMO71DilTfa3JotfsrrJYAGR311ZeByhrNKvWLUCi+WrjF3Ow5ynrIgEbE6o2uiLu2iAf3VDG2zlH5vHkyFarPfJOnN0RVJ0HOns+QBV+6YzMIFdbjscFvM8I86a7NTBP3wdRkGM2xgFM/C8t20Qt0/BjMIFc9xc3i/xYRWABCcfPqfMIEqacJ55jJ2gfjHtwcPC6JiMaKeRsTzA/anTbmnch3P27Mg9l12cFKKTSCleQpBJGUwQ8TNeeSzmnlO0EUL3t4flVz3c8oko0HRpkL6xIZHLbgnFtqEI0gYAG0Bny4+NS3QZTvozm5tkMHbD5yRyCEHYyZDPkhmkraWArsnRjcxc2YwTHUXhRwjcFluv+D0zuznE+Rh6EcN0A817v3PncdlV9K/TPVWARevtYf4aavOKuZUuK8JGrr/kFdDqdS1FkFW7nvCdQnhpOjUhiWzVKMPN14oRZ3Cgq9VxyiMqznkT9s9jIADISJ7HsEO5zkcCNuVAQUDQ3UDpGCH7USegiaqdW2Hr8C1jCnFCAAAAAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

